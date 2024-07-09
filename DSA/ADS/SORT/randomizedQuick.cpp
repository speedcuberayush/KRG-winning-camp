#include <bits/stdc++.h>
using namespace std;
class Solution
{
public:
    void sortColors(vector<int> &nums)
    {
        quickSort(nums, 0, nums.size() - 1);
    }

private:
    void quickSort(vector<int> &nums, int low, int high)
    {
        if (low < high)
        {
            int pivotIndex = randomizedPartition(nums, low, high);
            quickSort(nums, low, pivotIndex - 1);
            quickSort(nums, pivotIndex + 1, high);
        }
    }

    int randomizedPartition(vector<int> &nums, int low, int high)
    {
        int pivotIndex = low + rand() % (high - low + 1);
        swap(nums[pivotIndex], nums[high]);
        return partition(nums, low, high);
    }

    int partition(vector<int> &nums, int low, int high)
    {
        int pivot = nums[high];
        int i = low - 1;
        for (int j = low; j < high; ++j)
            if (nums[j] < pivot)
                swap(nums[++i], nums[j]);

        swap(nums[i + 1], nums[high]);
        return i + 1;
    }
};