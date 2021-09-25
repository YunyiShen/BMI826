#include<iostream>
#include<string.h>
#include<fstream>
#include<sstream>
#include<vector>
#include<set>
#include<map>
#include<queue>

using namespace std;

#define INF_  2147483647// effectively infinity


template<typename T>
class Edge{// class for edges, useful in adjecency list
    public: 
        T vertex;
        Edge() = default;
        Edge(T neighbor): vertex(neighbor){}
        bool operator<(const Edge & obj) const {
            return obj.vertex > vertex;
        }
        bool operator==(const Edge & obj) const{
            return obj.vertex==vertex;
        }
};

template<typename T>
class Graph{// a graph class
    public:
        map<T, set<Edge<T>>> adj; // adjacency list, map vertex to its edge
        Graph() = default;
        bool contain(T vertex); // see if vertex is in 
        bool adjacent(T v1, T v2);
        void add_vertex(T vertex); // add v
        void add_edge(T v1, T v2); // add edge
        void fromfile(string file); // construct from a file with edges
        vector<T> get_verteces(); // get all verteces
        map<T, int> dijkstra(T init); // find the least distance route
        double precision(Graph<T> graph2);
};

template<typename T> bool Graph<T>::contain(T vertex){
    return adj.find(vertex) != adj.end();
}

template<typename T> bool Graph<T>::adjacent(T v1, T v2){
    if(this->contain(v1) && this->contain(v2) && v1!=v2){
        for(Edge<T> edge : adj[v1]){
            if(edge.vertex==v2){
                return true;
            }
        }
    }
    return false;
}

template<typename T> void Graph<T>::add_vertex(T vertex){
    if(!this->contain(vertex)){// if not yet in the graph
        set<Edge<T>> edges;
        adj[vertex] = edges;
    }
}

template<typename T> void Graph<T>::add_edge(T v1, T v2){
    if(! this->adjacent(v1,v2)){
        adj[v1].insert(Edge<T>(v2));
        adj[v2].insert(Edge<T>(v1));
    }
}

template<typename T> void Graph<T>::fromfile(string file){
    ifstream fin;
    fin.open(file, ios::in);
    if(!fin){
        throw std::invalid_argument("cannot open the file");
    }  
    char line[1024]={0};
    string v1, v2;
    while(fin.getline(line,sizeof(line)))
    {

        std::stringstream word(line);
        word >> v1 ;
        word >> v2;
        //cout << "v1:" << v1 << " v2:" << v2 << endl;
        this->add_vertex(static_cast<T>(v1));
        this->add_vertex(static_cast<T>(v2));
        this->add_edge(static_cast<T>(v1),static_cast<T>(v2));
    }
}




template<typename T> vector<T> Graph<T>::get_verteces(){
    vector<T> res;
    for(auto vet : adj){
        res.push_back(vet.first);
    }
    return res;
}

template<typename T> map<T,int> Graph<T>:: dijkstra(T init){
    map<T, int> distance; // store the distance from init to all others
    // a priority queue, sort by the int of the pair
    priority_queue<pair<int,T>, vector<pair<int, T>>,greater<pair<int,T>>> q;

    // initialize the distance map
    for(T vert : this->get_verteces()){
        if(vert == init){
            distance[vert] = 0; // is the initial point itself
        }
        else{
            distance[vert] = INF_; // all others
        }
    }

    set<T> visited; // visited verteces

    // push the initial point to the queue
    q.push(make_pair(0,init)); // initial point has no distance

    while(!q.empty()){ // while still not empty
        auto front = q.top(); // take the first one
        q.pop();
        T u = front.second;

        if(visited.find(u) != visited.end()) continue;
        visited.insert(u);
        int shortest_dist_u = front.first;
        distance[u] = shortest_dist_u;

        // visit the unvisited neighbor of u
        for(auto v : adj[u]){
            if(visited.find(v.vertex)==visited.end()){
                q.push(make_pair(shortest_dist_u + 1, v.vertex));
            }
            
        }

    }
    return distance;
}


template<typename T> double Graph<T>::precision(Graph<T> graph2){
    int E2 = 0;
    //map<T, set<Edge<T>>>::iterator it;
    double res = 0;

    auto vertices = graph2.get_verteces();
    int n_vert = vertices.size();

    for(int i = 0 ; i < n_vert-1 ; i++){
        for(int j = i + 1 ; j < n_vert ; j++){
            T v1 = vertices[i];
            T v2 = vertices[j];
            if(graph2.adjacent(v1,v2)){
                E2 ++;
                // if it is in...
                if( this->contain(v1) && this->contain(v2)){// if it is in current graph
                    map<T,int> dist =  this->dijkstra(v1);// this might not be optimal, as we might recalculated something, but I am too lazy to optimize it
                    res += 1/((double)dist[v2]);
                }
                
            }
        }
    }
    
    return(res/E2);
}
