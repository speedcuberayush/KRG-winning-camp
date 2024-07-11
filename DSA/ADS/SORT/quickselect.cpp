#include <bits/stdc++.h>
using namespace std;

class Solution
{
public:
    int findKthLargest(vector<int> &nums, int k)
    {
        int start = 0, end = nums.size() - 1;
        while (true)
        {
            int piv = rand() % (end - start + 1) + start;
            int newPiv = partition(nums, start, end, piv);
            if (newPiv == nums.size() - k)
                return nums[newPiv];

            else if (newPiv > nums.size() - k)
                end = newPiv - 1;

            else
                start = newPiv + 1;
        }
    }

private:
    int partition(vector<int> &nums, int start, int end, int piv)
    {
        int pivot = nums[piv];
        swap(nums[piv], nums[end]);

        int temp = start;
        for (int i = start; i < end; i++)
            if (nums[i] < pivot)
                swap(nums[i], nums[temp++]);
        swap(nums[end], nums[temp]);
        return temp;
    }

    // void solve(vector<int> &arr, int s, int e)
    // {
    //     if (s < e)
    //     {
    //         int i = s - 1;
    //         for (int j = s; j < e; j++)
    //             if (arr[j] < arr[e])
    //                 swap(arr[++i], arr[j]);
    //         swap(arr[++i], arr[e]);
    //         solve(arr, s, i - 1);
    //         solve(arr, i + 1, e);
    //     }
    // }
};