#include <bits/stdc++.h>

using namespace std;
int N, a, b, p[1000], sz[1000];
vector<int> G[1000];

void dfs(int u = 1)
{
    sz[u] = 1;
    for (int v : G[u])
    {
        if (v != p[u])
        {
            p[v] = u;
            dfs(v);
            sz[u] += sz[v];
        }
    }
}

int main()
{
    int N;
    cin >> N;
    for (int i = 0; i < N - 1; i++)
    {
        int a, b;
        cin >> a >> b;
        G[a].push_back(b);
        G[b].push_back(a);
    }

    dfs();

    for (int i = 1; i <= N; i++)
    {
        bool centroid = true;
        if (p[i] != 0 && N - sz[i] > N / 2)
            centroid = false;

        for (int v : G[i])
            if (v != p[i] && sz[v] > N / 2)
                centroid = false;

        if (centroid)
        {
            cout << i << endl;
            return 0;
        }
    }
}