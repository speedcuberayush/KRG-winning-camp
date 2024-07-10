#include <bits/stdc++.h>
using namespace std;
void print(vector<int> &arr)
{
    for (auto it : arr)
        cout << it << " ";
    cout << endl;
}
int main()
{
    vector<int> arr = {1, 2, 2, 2, 2, 1, 0, 0, 0, 0, 1, 2};
    int n = arr.size();
    print(arr);

    int i = 0;
    int j = 0;
    int k = n - 1;
    while (j <= k)
    {
        if (arr[j] == 0)
            swap(arr[i++], arr[j++]);
        else if (arr[j] == 1)
            j++;
        else
            swap(arr[j], arr[k--]);
    }
    print(arr);
    return 0;
}