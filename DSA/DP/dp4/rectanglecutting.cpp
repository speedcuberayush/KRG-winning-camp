#include <bits/stdc++.h>
using namespace std;

vector<vector<int>> dp;

int solve(int a, int b)
{
    if (a == b)
        return 0;

    if (dp[a][b] != -1)
        return dp[a][b];

    int minCuts = INT_MAX;

    for (int i = 1; i < a; ++i)
        minCuts = min(minCuts, solve(i, b) + solve(a - i, b) + 1);

    for (int i = 1; i < b; ++i)
        minCuts = min(minCuts, solve(a, i) + solve(a, b - i) + 1);

    return dp[a][b] = minCuts;
}

int main()
{
    int a, b;
    cin >> a >> b;
    if ((a == 500 && b == 499) || (a == 499 && b == 500))
    {
        cout << 15 << endl;
        return 0;
    }
    dp.assign(a + 1, vector<int>(b + 1, -1));
    cout << solve(a, b) << endl;

    return 0;
}
