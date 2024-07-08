#include <bits/stdc++.h>
using namespace std;
#include <vector>
#define mod 1000000007
long long int solve(int n, vector<long long int> &dp)
{
    if (n == 0)
    {
        return 0;
    }
    if (n == 2)
    {
        return 1;
    }
    if (dp[n] != -1)
    {
        return dp[n];
    }
    dp[n] = (((n - 1) % mod) * ((solve(n - 1, dp) % mod) + (solve(n - 2, dp) % mod)) % mod);

    return dp[n];
}
long long int countDerangements(int n)
{
    vector<long long int> dp(n + 1, -1);
    return solve(n, dp);
}