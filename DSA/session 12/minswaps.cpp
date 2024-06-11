#include <bits/stdc++.h>
using namespace std;
void inorder(vector<int> &arr, vector<int> &in, int i)
{
    if (i >= arr.size())
        return;
    inorder(arr, in, 2 * i + 1);
    in.push_back(arr[i]);
    inorder(arr, in, 2 * i + 2);
}

int minimumSwaps(vector<int> &arr, int n)
{
    vector<int> in;
    inorder(arr, in, 0);
    int count = 0;
    map<int, int> mp;
    for (int i = 0; i < n; i++)
        mp[in[i]] = i;
    sort(in.begin(), in.end());
    int i = 0;
    while (i < n)
    {
        if (mp[in[i]] != i)
        {
            count++;
            swap(in[i], in[mp[in[i]]]);
            continue;
        }
        i++;
    }
    return count;
}