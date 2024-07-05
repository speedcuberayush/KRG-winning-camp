#include <bits/stdc++.h>
using namespace std;

class Solution
{
public:
    int solve(vector<int> &dp)
    {
        int n = dp.size();
        stack<int> stk;
        vector<int> prevSmall(n), nextSmall(n);

        for (int i = 0; i < n; i++)
        {
            while (!stk.empty() && dp[stk.top()] >= dp[i])
                stk.pop();
            prevSmall[i] = stk.empty() ? 0 : stk.top() + 1;
            stk.push(i);
        }
        for (auto i : prevSmall)
            cout << i << " ";
        cout << endl;
        for (auto i : nextSmall)
            cout << i << " ";
        cout << endl;
        while (!stk.empty())
            stk.pop();

        for (int i = n - 1; i >= 0; i--)
        {
            while (!stk.empty() && dp[stk.top()] >= dp[i])
                stk.pop();
            nextSmall[i] = stk.empty() ? n - 1 : stk.top() - 1;
            stk.push(i);
        }

        int area = 0;
        for (int i = 0; i < n; i++)
            area = max(area, dp[i] * (nextSmall[i] - prevSmall[i] + 1));

        return area;
    }

public:
    int maximalRectangle(vector<vector<char>> &matrix)
    {
        if (matrix.empty())
            return 0;

        int m = matrix.size();
        int n = matrix[0].size();
        vector<int> dp(n, 0);
        int ans = 0;

        for (int r = 0; r < m; ++r)
        {
            for (int c = 0; c < n; ++c)
                dp[c] = (matrix[r][c] == '1') ? dp[c] + 1 : 0;

            ans = max(ans, solve(dp));
        }

        return ans;
    }
};
int main()
{
    vector<int> dp = {3, 1, 3, 2, 2};
    Solution s;
    s.solve(dp);
    return 0;
}