#include <iostream>
#include <vector>
#include <algorithm>
using namespace std;

void arrangeArray(vector<int> &arr, int n)
{
    vector<int> odd, even;
    for (int i = 0; i < n; ++i)
    {
        if (i % 2 == 0)
            even.push_back(arr[i]);
        else
            odd.push_back(arr[i]);
    }
    sort(odd.begin(), odd.end());
    sort(even.begin(), even.end(), greater<int>());
    int i = 0, j = 0;
    for (int k = 0; k < n; ++k)
    {
        if (k % 2 == 0)
            arr[k] = even[i++];
        else
            arr[k] = odd[j++];
    }
}

int main()
{
    int T;
    cin >> T;

    while (T--)
    {
        int n;
        cin >> n;

        vector<int> arr(n);
        for (int i = 0; i < n; ++i)
            cin >> arr[i];

        arrangeArray(arr, n);

        for (int i = 0; i < n; ++i)
            cout << arr[i] << " ";
        cout << endl;
    }

    return 0;
}
