#include <bits/stdc++.h>
using namespace std;

void dfs(int node, vector<vector<int>> &graph, vector<bool> &visited, vector<int> &component)
{
    stack<int> stk;
    stk.push(node);
    visited[node] = true;

    while (!stk.empty())
    {
        int current = stk.top();
        stk.pop();
        component.push_back(current);

        for (int neighbor : graph[current])
        {
            if (!visited[neighbor])
            {
                visited[neighbor] = true;
                stk.push(neighbor);
            }
        }
    }
}

int main()
{
    int n, m;
    cin >> n >> m;

    vector<int> balance(n);
    for (int i = 0; i < n; ++i)
        cin >> balance[i];

    vector<vector<int>> graph(n);
    for (int i = 0; i < m; ++i)
    {
        int u, v;
        cin >> u >> v;
        graph[u].push_back(v);
        graph[v].push_back(u);
    }

    vector<bool> visited(n, false);
    bool possible = true;

    for (int i = 0; i < n; ++i)
    {
        if (!visited[i])
        {
            vector<int> component;
            dfs(i, graph, visited, component);
            int componentBalance = 0;
            for (int person : component)
                componentBalance += balance[person];

            if (componentBalance != 0)
            {
                possible = false;
                break;
            }
        }
    }

    if (possible)
    {
        cout << "POSSIBLE" << endl;
    }
    else
    {
        cout << "IMPOSSIBLE" << endl;
    }

    return 0;
}
