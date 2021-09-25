#include "Graph.hpp"


int main(int argc, char **argv){
    if(argc < 4){
        throw std::invalid_argument( "lacking more than one argument" );
    }
    string file = argv[1];
    string init = argv[2];
    string dest = argv[3];

    // initialize the instance
    Graph<string> graph;
    graph.fromfile(file);

    if(!graph.contain(init)){
        throw std::invalid_argument( "initial point is not in the graph" );
    }
    if(!graph.contain(dest)){
        throw std::invalid_argument( "destination point is not in the graph" );
    }

    map<string,int> res =  graph.dijkstra(init);

    if(res[dest]==INF_){
        cout << "false" << endl;
    }
    else{
        cout << "true" << " " << res[dest] << endl;
    }
    
    return 0;
}