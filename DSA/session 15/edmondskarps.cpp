#include <iostream>
#include <vector>
#include <queue>
#include <cstring>
#include <algorithm>
using namespace std;

const int INF = 1e9;
bool bfs(int n, vector<vector<int>> &capacity, vector<int> &parent, int source, int sink)
{
    vector<bool> visited(n, false);
    queue<int> q;
    q.push(source);
    visited[source] = true;
    parent[source] = -1;

    while (!q.empty())
    {
        int current = q.front();
        q.pop();

        for (int next = 0; next < n; ++next)
        {
            if (!visited[next] && capacity[current][next] > 0)
            {
                parent[next] = current;
                if (next == sink)
                {
                    return true;
                }
                visited[next] = true;
                q.push(next);
            }
        }
    }
    return false;
}

// Edmonds-Karp algorithm to find the maximum flow from source to sink
int edmonds_karp(int n, vector<vector<int>> &capacity, int source, int sink)
{
    vector<int> parent(n);
    int max_flow = 0;

    while (bfs(n, capacity, parent, source, sink))
    {
        int path_flow = INF;
        int s = sink;

        while (s != source)
        {
            int u = parent[s];
            path_flow = min(path_flow, capacity[u][s]);
            s = u;
        }

        s = sink;
        while (s != source)
        {
            int u = parent[s];
            capacity[u][s] -= path_flow;
            capacity[s][u] += path_flow;
            s = u;
        }

        max_flow += path_flow;
    }

    return max_flow;
}

int main()
{
    int n, m;
    cin >> n >> m;

    // Initialize the capacity matrix
    vector<vector<int>> capacity(n, vector<int>(n, 0));

    for (int i = 0; i < m; ++i)
    {
        int a, b, c;
        cin >> a >> b >> c;
        --a;                 // Adjusting to 0-based index
        --b;                 // Adjusting to 0-based index
        capacity[a][b] += c; // In case of multiple edges, we sum the capacities
    }

    int source = 0;   // Server (node 1 in 1-based index, node 0 in 0-based index)
    int sink = n - 1; // Kotivalo's computer (node n in 1-based index, node n-1 in 0-based index)

    cout << edmonds_karp(n, capacity, source, sink) << endl;

    return 0;
}
