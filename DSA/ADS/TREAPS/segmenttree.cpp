#include <bits/stdc++.h>
using namespace std;

class NumArray
{
public:
    vector<int> seg;
    int n;
    void buildTree(vector<int> &nums, int ind, int left, int right)
    {
        if (left == right)
        {
            seg[ind] = nums[left];
            return;
        }
        int mid = (left + right) / 2;

        buildTree(nums, 2 * ind + 1, left, mid);
        buildTree(nums, 2 * ind + 2, mid + 1, right);

        seg[ind] = seg[2 * ind + 1] + seg[2 * ind + 2];
    }

    void solve1(int ind, int left, int right, int index, int val)
    {
        if (index < left || index > right)
            return;

        if (left == right)
        {
            seg[ind] = val;
            return;
        }

        int mid = (left + right) / 2;

        solve1(2 * ind + 1, left, mid, index, val);
        solve1(2 * ind + 2, mid + 1, right, index, val);

        seg[ind] = seg[2 * ind + 1] + seg[2 * ind + 2];
    }

    int solve2(int qlow, int qhigh, int low, int high, int ind)
    {
        if (qlow <= low && qhigh >= high)
            return seg[ind];

        if (qlow > high || qhigh < low)
            return 0;

        int mid = low + (high - low) / 2;
        return (solve2(qlow, qhigh, low, mid, 2 * ind + 1) + solve2(qlow, qhigh, mid + 1, high, 2 * ind + 2));
    }

    NumArray(vector<int> &nums)
    {
        if (nums.size() > 0)
        {
            n = nums.size();
            buildTree(nums, 0, 0, n - 1);
        }
    }

    void update(int index, int val)
    {
        if (n == 0)
            return;
        solve1(0, 0, n - 1, index, val);
    }

    int sumRange(int left, int right)
    {
        if (n == 0)
            return 0;
        return solve2(left, right, 0, n - 1, 0);
    }
};