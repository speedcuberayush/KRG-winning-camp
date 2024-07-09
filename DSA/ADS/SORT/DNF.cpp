
#include <bits/stdc++.h>
using namespace std;

void sortA(vector<int> &arr, int n)
{

    int low = 0, mid = 0, high = n - 1;
    while (mid <= high)
    {
        if (arr[mid] == 0)
            swap(arr[low++], arr[mid++]);
        else if (arr[mid] == 1)
            mid++;
        else
            swap(arr[mid], arr[high--]);
    }
}

int main()
{
    int n = 6;
    vector<int> arr = {0, 2, 1, 2, 0, 1};
    sortA(arr, n);
    cout << "After sorting:" << endl;
    for (int i = 0; i < n; i++)
        cout << arr[i] << " ";

    cout << endl;
    return 0;
}
