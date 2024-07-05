#include <bits/stdc++.h>
using namespace std;
int solve(int *A, int n)
{
    if (n <= 2)
        return n;

    int max_len = 2;
    for (int i = 0; i < n - 1; i++)
    {
        for (int j = i + 1; j < n; j++)
        {
            int diff = A[j] - A[i];
            int cur_len = 2;
            int last = A[j];
            for (int k = j + 1; k < n; k++)
                if (A[k] - last == diff)
                {
                    cur_len++;
                    last = A[k];
                }
            max_len = max(cur_len, max_len);
        }
    }

    return max_len;
}

int main()
{
    int arr[100];
    cout << "Enter the size of the array: ";
    int size;
    cin >> size;
    for (int i = 0; i < size; i++)
        cin >> arr[i];

    cout << solve(arr, size);
    return 0;
}