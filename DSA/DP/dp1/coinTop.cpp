#include <iostream>
#include <vector>

using namespace std;

const int MOD = 1e9 + 7;

int countWays(int x, vector<int> &coins, vector<int> &dp)
{
    if (x == 0)
        return 1;

    if (x < 0)
        return 0;

    if (dp[x] != -1)
        return dp[x];

    int ways = 0;
    for (int coin : coins)
        ways = (ways + countWays(x - coin, coins, dp)) % MOD;

    dp[x] = ways;
    return ways;
}

int main()
{
    int n, x;
    cin >> n >> x;
    vector<int> coins(n);
    for (int i = 0; i < n; ++i)
        cin >> coins[i];

    vector<int> dp(x + 1, -1);

    int result = countWays(x, coins, dp);

    cout << result << endl;

    return 0;
}
