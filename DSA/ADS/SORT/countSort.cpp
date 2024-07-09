#include <bits/stdc++.h>
using namespace std;

vector<int> countSort(vector<int> &arr)
{
    int N = arr.size();
    int M = *max_element(arr.begin(), arr.end());
    vector<int> count(M + 1, 0);
    for (int i = 0; i < N; i++)
        count[arr[i]]++;

    for (int i = 1; i <= M; i++)
        count[i] += count[i - 1];
    vector<int> ans(N);

    for (int i = N - 1; i >= 0; i--)
        ans[--count[arr[i]]] = arr[i];

    return ans;
}

int main()
{
    vector<int> arr = {9, 7, 2, 4, 1};
    cout << "Original array: ";
    for (auto i : arr)
        cout << i << " ";
    cout << endl;

    arr = countSort(arr);

    cout << "Sorted array: ";
    for (auto i : arr)
        cout << i << " ";
    cout << endl;

    return 0;
}
