#include <bits/stdc++.h>
using namespace std;
bool check(int i, int j, string &a)
{
    while (i <= j)
    {
        if (a[i] != a[j])
            return 0;
        i++;
        j--;
    }

    return 1;
}

int solve(int i, int j, string &a, vector<vector<int>> &dp)
{

    if (i == j)
        return 0;

    if (check(i, j, a))
        return 0;

    if (dp[i][j] != -1)
        return dp[i][j];

    int cuts = INT_MAX;
    for (int k = i; k < j; k++)
    {
        int ans = solve(i, k, a, dp) + solve(k + 1, j, a, dp);
        cuts = min(cuts, ans + 1);
    }

    return dp[i][j] = cuts;
}

int Solution::minCut(string a)
{
    int n = a.size();
    vector<vector<int>> dp(n, vector<int>(n, -1));
    return solve(0, n - 1, a, dp);
}
