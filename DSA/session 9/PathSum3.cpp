#include <bits/stdc++.h>
using namespace std;
class Solution
{
public:
    int pathSum(TreeNode *root, int sum)
    {
        unordered_map<int, int> m;
        m[0]++;

        int total = 0;
        solve(root, 0, sum, total, m);
        return total;
    }

    void solve(TreeNode *p, int cur, int sum, int &total, unordered_map<int, int> &m)
    {
        if (!p)
            return;

        cur += p->val;
        if (m.find(cur - sum) != m.end())
            total += m[cur - sum];
        m[cur]++;

        solve(p->left, cur, sum, total, m);
        solve(p->right, cur, sum, total, m);

        m[cur]--;
    }
};