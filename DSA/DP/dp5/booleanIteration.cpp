#include <bits/stdc++.h>
using namespace std;

class Solution
{
public:
    int countWays(int n, string s)
    {
        const int MOD = 1003;
        vector<vector<vector<int>>> dp(n, vector<vector<int>>(n, vector<int>(2, 0)));

        for (int i = 0; i < n; i += 2)
        {
            dp[i][i][1] = (s[i] == 'T') ? 1 : 0;
            dp[i][i][0] = (s[i] == 'F') ? 1 : 0;
        }

        for (int length = 3; length <= n; length += 2)
        {
            for (int i = 0; i <= n - length; i += 2)
            {
                int j = i + length - 1;
                dp[i][j][1] = 0;
                dp[i][j][0] = 0;

                for (int k = i + 1; k < j; k += 2)
                {
                    char oper = s[k];
                    int lt = dp[i][k - 1][1];
                    int lf = dp[i][k - 1][0];
                    int rt = dp[k + 1][j][1];
                    int rf = dp[k + 1][j][0];

                    if (oper == '&')
                    {
                        dp[i][j][1] += (lt * rt) % MOD;
                        dp[i][j][0] += (lt * rf + lf * rt + lf * rf) % MOD;
                    }
                    else if (oper == '|')
                    {
                        dp[i][j][1] += (lt * rt + lt * rf + lf * rt) % MOD;
                        dp[i][j][0] += (lf * rf) % MOD;
                    }
                    else if (oper == '^')
                    {
                        dp[i][j][1] += (lt * rf + lf * rt) % MOD;
                        dp[i][j][0] += (lt * rt + lf * rf) % MOD;
                    }

                    dp[i][j][1] %= MOD;
                    dp[i][j][0] %= MOD;
                }
            }
        }

        return dp[0][n - 1][1];
    }
};

int main()
{
    Solution sol;
    cout << sol.countWays(7, "T|T&F^T") << endl;
    cout << sol.countWays(5, "T^F|F") << endl;
    return 0;
}
