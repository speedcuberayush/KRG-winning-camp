#include <vector>
#include <cmath>

class Solution
{
public:
    long long powMod(long long a, long long b, long long mod)
    {
        long long result = 1;
        while (b > 0)
        {
            if (b % 2 == 1)
                result = result * a % mod;
            a = a * a % mod;
            b /= 2;
        }
        return result;
    }

    long long comb(int n, int r)
    {
        if (r > n)
            return 0;
        return factorial[n] * invFactorial[r] % MOD * invFactorial[n - r] % MOD;
    }

    long long helper(const std::vector<int> &seq)
    {
        if (seq.size() <= 1)
            return 1;
        int root = seq[0];
        std::vector<int> left, right;
        for (int i = 1; i < seq.size(); ++i)
        {
            if (seq[i] < root)
                left.push_back(seq[i]);
            else
                right.push_back(seq[i]);
        }
        long long leftWays = helper(left) % MOD;
        long long rightWays = helper(right) % MOD;
        return leftWays * rightWays % MOD * comb(seq.size() - 1, left.size()) % MOD;
    }

    int numOfWays(std::vector<int> &nums)
    {
        const int MOD = 1e9 + 7;
        int n = nums.size();
        std::vector<long long> factorial(n + 1, 1);
        std::vector<long long> invFactorial(n + 1, 1);

        for (int i = 2; i <= n; ++i)
        {
            factorial[i] = factorial[i - 1] * i % MOD;
        }

        invFactorial[n] = powMod(factorial[n], MOD - 2, MOD);
        for (int i = n - 1; i >= 1; --i)
        {
            invFactorial[i] = invFactorial[i + 1] * (i + 1) % MOD;
        }
        return (helper(nums) - 1 + MOD) % MOD;
    }
};
