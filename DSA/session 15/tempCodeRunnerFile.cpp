#include <iostream>
#include <vector>
#include <queue>
#include <set>

using namespace std;

vector<int> topologicalSort(const vector<vector<int>> &adj, int n)
{
    vector<int> inDegree(n, 0);
    for (const auto &neighbors : adj)

        for (int v : neighbors)
            inDegree[v]++;

    queue<int> q;
    for (int i = 0; i < n; ++i)
        if (inDegree[i] == 0)
            q.push(i);

    vector<int> topoOrder;
    while (!q.empty())
    {
        int u = q.front();
        q.pop();
        topoOrder.push_back(u);
        for (int v : adj[u])
        {
            inDegree[v]--;
            if (inDegree[v] == 0)
                q.push(v);
        }
    }

    return topoOrder;
}

int main()
{
    int L, U, n, m;
    cin >> L >> U >> n >> m;

    vector<vector<int>> adj(n);

    for (int i = 0; i < m; ++i)
    {
        int u, v;
        cin >> u >> v;
        adj[u].push_back(v);
    }

    vector<int> topoOrder = topologicalSort(adj, n);
    set<int> certainL;
    for (int i = 0; i < L; ++i)
        certainL.insert(topoOrder[i]);

    set<int> certainU;
    for (int i = 0; i < U; ++i)
        certainU.insert(topoOrder[i]);

    set<int> neverPromoted;
    for (int i = U; i < n; ++i)
        neverPromoted.insert(topoOrder[i]);

    cout << certainL.size() << endl;
    cout << certainU.size() << endl;
    cout << neverPromoted.size() << endl;

    return 0;
}
