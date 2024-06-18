#include <bits/stdc++.h>
using namespace std;

class Graph
{
public:
    vector<vector<int>> adjList;
    int n;

    Graph(int nodes) : n(nodes)
    {
        adjList.resize(n);
    }

    void addEdge(int u, int v)
    {
        adjList[u].push_back(v);
    }
    void print()
    {

        for (int i = 0; i < adjList.size(); i++)
        {
            cout << i << ": ";
            for (auto it : adjList[i])
                cout << it << " ";
            cout << endl;
        }
    }
};

class Solution
{
public:
    bool isStronglyConnected(Graph const &graph)
    {
        int n = graph.n;
        if (n == 0)
            return true;

        vector<bool> visited(n, false);
        dfs(graph.adjList, 0, visited);
        for (bool nodeVisited : visited)
            if (!nodeVisited)
                return false;

        vector<vector<int>> transposedAdjList(n);
        for (int u = 0; u < n; ++u)
            for (int v : graph.adjList[u])
                transposedAdjList[v].push_back(u);

        visited.assign(n, false);
        dfs(transposedAdjList, 0, visited);

        for (bool nodeVisited : visited)
            if (!nodeVisited)
                return false;

        return true;
    }

private:
    void dfs(const vector<vector<int>> &adjList, int node, vector<bool> &visited)
    {
        stack<int> s;
        s.push(node);

        while (!s.empty())
        {
            int curr = s.top();
            s.pop();

            if (!visited[curr])
            {
                visited[curr] = true;
                for (int neighbor : adjList[curr])
                    if (!visited[neighbor])
                        s.push(neighbor);
            }
        }
    }
};

int main()
{

    Graph graph1(5);
    graph1.addEdge(1, 0);
    graph1.addEdge(0, 4);
    graph1.addEdge(2, 4);
    graph1.addEdge(1, 2);
    graph1.addEdge(2, 1);
    graph1.addEdge(3, 1);
    graph1.addEdge(3, 2);
    graph1.addEdge(4, 3);

    graph1.print();
    Solution sol;
    cout << (sol.isStronglyConnected(graph1) ? "true" : "false") << endl;

    return 0;
}
