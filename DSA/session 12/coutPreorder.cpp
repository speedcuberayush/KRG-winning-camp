#include <bits/stdc++.h>
using namespace std;
int CountBinaryTrees(int n)
{
    int Count[n + 1] = {0};
    Count[0] = Count[1] = 1;
    for (int i = 2; i <= n; ++i)
        for (int j = 0; j < i; j++)
            Count[i] += Count[j] * Count[i - j - 1];
    return Count[n];
}
int main()
{
    while (1)
    {

        int n;
        cin >> n;
        cout << "for length " << n << " ans: " << CountBinaryTrees(n) << endl;
    }
    return 0;
}