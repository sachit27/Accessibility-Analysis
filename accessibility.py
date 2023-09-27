# Import required libraries
import branca.colormap as cm
import folium
import geopandas as gpd
import networkx as nx
import osmnx as ox
import pandas as pd

# Load the walking network graph for a specified city (Default: Madrid, Spain)
G = ox.graph_from_place("Madrid, Spain",  network_type="walk", buffer_dist = 500) 

# Convert graph nodes to GeoDataFrame
gdf_nodes = ox.graph_to_gdfs(G, edges=False)

# Initialize folium map centered around Madrid
m = folium.Map(
    location=[40.42270213582769, -3.7038863013248826],
    zoom_start=15,
    prefer_canvas=True,control_scale=True,
)

# Add nodes to the map
for index, val in gdf_nodes.iterrows():
    folium.Circle(
        location=[val["y"], val["x"]],
        radius=10,
        stroke=False,
        fill=True,
        fill_opacity=0.5,
        interactive=True,
    ).add_to(m)
    
m

# List key-value pairs for green spaces
newtags = {'leisure': 'park','landuse': 'recreation_ground'}
greenspaces = ox.geometries_from_place("Madrid, Spain", tags=newtags)
#greenspaces.plot(color="green");


# Create a dataframe to save the id, lat, lon and size of green spaces
greenspaces_df = pd.DataFrame(columns=['id','lat','lon','size'])


# Loop through the list of green spaces and save the id, lat, lon and size of green spaces
for i in range(len(greenspaces)):
    greenspaces_df.loc[i] = [greenspaces.index[i], greenspaces.geometry[i].centroid.y, greenspaces.geometry[i].centroid.x, greenspaces.geometry[i].area]


crs = greenspaces.crs
print(crs)


# Save the data as a CSV file
greenspaces_df.to_csv('greenspaces_md.csv')


all_sub_df = pd.read_csv("greenspaces_md.csv")

# Define a dictionary class to store smallest distance values
class DictSmallest(dict):
    def __setitem__(self, key, value):
        if (key not in self) or (key in self and self[key] > value):
            dict.__setitem__(self, key, value)
    def update(self, dict):
        for key, value in dict.items():
            if (key not in self) or (key in self and self[key] > value):
                self[key] =  value

# Create a list of nearest nodes to each point of interest
list_of_poi = []
for index, row in all_sub_df.iterrows():
    list_of_poi.append(ox.distance.nearest_nodes(G, Y=row.lat, X=row.lon))

G = ox.project_graph(G)



# Calculate shortest path lengths and store them in a dictionary
node_distances = DictSmallest()
for poi in list_of_poi:
    tmp_res = nx.shortest_path_length(G, source=poi)
    node_distances.update(tmp_res)

coords = {key: {"lon": G.nodes[key]["lon"], "lat": G.nodes[key]["lat"], "distance": node_distances[key]} for key in node_distances}


trip_times = range(1, 51, 1)

iso_colors = ox.plot.get_colors(n=len(trip_times), cmap='plasma', start=0.3, return_hex=True)
iso_colors.reverse()

colormap = cm.LinearColormap(colors=iso_colors)
colormap = colormap.to_step(index=range(0, 51, 5))
    
def color_mapping_function(val, iso_colors):

    for time, color in zip(trip_times, iso_colors):
        if val < time :
            return color

    return iso_colors[-1]



coords = {key: {"x": G.nodes[key]["lon"], "y": G.nodes[key]["lat"], "color": color_mapping_function(node_distances[key], iso_colors)} for key in list(G.nodes())}



colormap = cm.LinearColormap(colors=iso_colors)
colormap = colormap.to_step(index=range(0, 51, 5))
colormap.caption = "Walking time to the nearest green space "

m = folium.Map(
    location=[40.42270213582769, -3.7038863013248826],
    zoom_start=12,
    prefer_canvas=True,control_scale=True,
)


for val in coords.values():
    folium.Circle(
        location=[val["y"], val["x"]],
        radius=50,
        stroke=False,
        fill=True,
        color=val["color"],
        fill_opacity=0.4,
        interactive=True,
    ).add_to(m)
colormap.add_to(m)

m

# Calculate average and longest walking times to the nearest green space
avg_walk_time = sum(node_distances.values())/len(node_distances.values())
print("Average walking time to the nearest green space in minutes: " + str(avg_walk_time))

max_walk_time = max(node_distances.values())
print("Longest walking time to the nearest green space in minutes: " + str(max_walk_time))
