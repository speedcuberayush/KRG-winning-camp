#include <iostream>
#include <vector>
#include <unordered_set>
using namespace std;

void dfs(int node, vector<vector<int>> &graph, vector<bool> &visited)
{
    visited[node] = true;
    for (int neighbor : graph[node])
        if (!visited[neighbor])

            dfs(neighbor, graph, visited);
}

int countConnectedComponents(int n, vector<vector<int>> &graph)
{
    vector<bool> visited(n, false);
    int components = 0;

    for (int i = 0; i < n; ++i)
    {
        if (!visited[i])
        {
            dfs(i, graph, visited);
            components++;
        }
    }

    return components;
}

int main()
{
    int T;
    cin >> T;

    for (int t = 0; t < T; ++t)
    {
        int n;
        cin >> n;
        vector<vector<int>> graph(n);

        int m;
        cin >> m;
        for (int i = 0; i < m; ++i)
        {
            int u, v;
            cin >> u >> v;
            graph[u].push_back(v);
            graph[v].push_back(u);
        }

        int components = countConnectedComponents(n, graph);
        int min_roads = components - 1;
        cout << min_roads << endl;
    }

    return 0;
}
