#include <bits/stdc++.h>
using namespace std;

class Solution
{
public:
    int maxSizeSlices(vector<int> &slices)
    {
        int n = slices.size();
        vector<vector<int>> dp1(n, vector<int>(n, -1));
        vector<vector<int>> dp2(n, vector<int>(n, -1));

        int case1 = maxSumSlices(slices, 0, n - 2, n / 3, dp1);
        int case2 = maxSumSlices(slices, 1, n - 1, n / 3, dp2);

        return max(case1, case2);
    }

private:
    int maxSumSlices(vector<int> &slices, int start, int end, int picks, vector<vector<int>> &dp)
    {
        if (picks == 0 || start > end)
            return 0;

        if (dp[start][picks] != -1)

            return dp[start][picks];

        int skip = maxSumSlices(slices, start + 1, end, picks, dp);
        int take = slices[start] + maxSumSlices(slices, start + 2, end, picks - 1, dp);

        dp[start][picks] = max(skip, take);

        return dp[start][picks];
    }
};
