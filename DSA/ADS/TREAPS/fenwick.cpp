#include <bits/stdc++.h>
using namespace std;

class BIT
{
    vector<int> bit;

public:
    BIT(int size = 0)
    {
        bit.assign(size + 1, 0);
    }
    int getSum(int i)
    {
        int sum = 0;
        for (; i > 0; i -= i & (-i))
            sum += bit[i];
        return sum;
    }
    void addValue(int i, int val)
    {
        for (; i < bit.size(); i += i & (-i))
            bit[i] += val;
    }
};
class NumArray
{
    BIT bit;
    vector<int> nums;

public:
    NumArray(vector<int> &nums)
    {
        this->bit = BIT(nums.size());
        this->nums = nums;
        for (int i = 0; i < nums.size(); ++i)
            bit.addValue(i + 1, nums[i]);
    }
    void update(int index, int val)
    {
        int diff = val - nums[index];
        bit.addValue(index + 1, diff);
        nums[index] = val;
    }
    int sumRange(int left, int right)
    {
        return bit.getSum(right + 1) - bit.getSum(left);
    }
};