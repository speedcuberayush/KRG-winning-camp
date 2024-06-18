#include <bits/stdc++.h>
using namespace std;
void print(vector<int> arr)
{
    for (auto it : arr)
        cout << it << " ";
    cout << endl;
}
void sort(vector<int> &arr, int s, int e)
{
    if (s > e)
        return;
    int i = s - 1;
    for (int j = s; j < e; j++)
        if (arr[j] < arr[e])
            swap(arr[++i], arr[j]);
    swap(arr[++i], arr[e]);

    sort(arr, s, i - 1);
    sort(arr, i + 1, e);
}
int main()
{
    int n;
    cout << "Enter the size: ";
    cin >> n;
    vector<int> arr(n);
    for (int i = 0; i < n; i++)
        cin >> arr[i];
    cout << "BEFORE SORTING" << endl;
    print(arr);
    sort(arr, 0, n - 1);
    cout << "AFTER SORTING" << endl;
    print(arr);

    return 0;
}