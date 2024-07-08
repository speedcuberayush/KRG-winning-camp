#include <bits/stdc++.h>
using namespace std;
#include <vector>
#define MOD 1000000007

long long int countDerangements(int n)
{
    if (n == 1)
        return 0;

    if (n == 2)
        return 1;

    long long int prev2 = 0;
    long long int prev1 = 1;

    for (int i = 3; i <= n; i++)
    {

        long long first = prev1 % MOD;
        long long second = prev2 % MOD;
        long long int sum = (first + second) % MOD;
        long long int ans = ((i - 1) * sum) % MOD;
        prev2 = prev1;
        prev1 = ans;
    }

    return prev1;
}
