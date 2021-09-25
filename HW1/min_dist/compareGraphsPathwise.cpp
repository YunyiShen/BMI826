#include "Graph.hpp"


int main(int argc, char **argv){
    if(argc < 3){
        throw std::invalid_argument( "lacking more than one argument" );
    }
    string file1 = argv[1];
    string file2 = argv[2];

    Graph<string> graph1;
    Graph<string> graph2;
    graph1.fromfile(file1);
    graph2.fromfile(file2);

    double precision = graph1.precision(graph2);
    double recall = graph2.precision(graph1);
    double Fscore = 2 * precision * recall / (precision+recall);
    cout << "precision: " << precision << "\nrecall: " << recall << "\nFscore: " << Fscore << endl;
    return 0;
}