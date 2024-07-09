#include <bits/stdc++.h>
using namespace std;
int par[100001], R[100001];
map<int, int> mp;
int Max = 1;

int find(int n)

{
    if (n == par[n])
        return n;
    return par[n] = find(par[n]);
}

void setUnion(int a, int b)
{
    if (R[a] < R[b])
        swap(a, b);

    par[b] = a;
    mp[R[a]]--, mp[R[b]]--;
    if (mp[R[a]] == 0)
        mp.erase(mp.find(R[a]));

    if (mp[R[b]] == 0)
        mp.erase(mp.find(R[b]));

    R[a] += R[b];
    Max = max(Max, R[a]);

    mp[R[a]]++;
}

int main()
{

    int n, q;
    cin >> n >> q;
    for (int i = 1; i <= n; i++)
    {
        par[i] = i;
        R[i] = 1;
        mp[R[i]]++;
    }

    while (q--)

    {
        int a, b;
        cin >> a >> b;
        a = find(a), b = find(b);

        if (a != b)
        {
            setUnion(a, b);
            cout << Max - mp.begin()->first << "\n";
        }

        else
            cout << Max - mp.begin()->first << "\n";
    }
}
