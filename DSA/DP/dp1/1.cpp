#include <bits/stdc++.h>
using namespace std;
class Solution
{
public:
    int robHouse(vector<int> &nums)
    {
        int n = nums.size();

        if (n == 1)
            return nums[0];

        if (n == 2)
            return max(nums[0], nums[1]);

        int prev2 = 0;
        int prev1 = nums[0];

        int curr = 0;

        for (int i = 1; i < n; i++)
        {
            int pick = nums[i];
            if (i > 1)
                pick += prev2;

            int notPick = prev1;

            curr = max(pick, notPick);

            prev2 = prev1;
            prev1 = curr;
        }

        return prev1;
    }

    int rob(vector<int> &nums)
    {
        int n = nums.size();
        if (n == 1)
            return nums[0];

        if (n == 2)
            return max(nums[0], nums[1]);

        vector<int> sFirst(nums.begin(), nums.end() - 1);
        vector<int> sLast(nums.begin() + 1, nums.end());

        return max(robHouse(sFirst), robHouse(sLast));
    }
};