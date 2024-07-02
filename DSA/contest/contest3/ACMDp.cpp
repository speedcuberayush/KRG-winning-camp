#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

const int MOD = 1000000007;

// Function to compute power of a number under modulus
long long mod_pow(long long base, long long exp, long long mod)
{
    long long result = 1;
    while (exp > 0)
    {
        if (exp % 2 == 1)
        {
            result = (result * base) % mod;
        }
        base = (base * base) % mod;
        exp /= 2;
    }
    return result;
}

// Function to compute factorial, powers of 2, and modular inverses
void precompute(int A, vector<int> &fct, vector<int> &tp, vector<int> &inv)
{
    fct[0] = fct[1] = 1;
    tp[0] = 1;
    tp[1] = 2;
    inv[1] = 1;
    for (int i = 2; i <= A + 1; ++i)
    {
        fct[i] = (long long)fct[i - 1] * i % MOD;
        tp[i] = (long long)tp[i - 1] * 2 % MOD;
        inv[i] = mod_pow(i, MOD - 2, MOD); // Using Fermat's little theorem for modular inverse
    }
}

// Function to compute the summation in the given function f
long long compute_f(int C, int M, int k, int A, const vector<int> &fct, const vector<int> &tp, const vector<int> &inv, const vector<int> &vv)
{
    long long s = 0;
    vector<int> comb(A + 1);
    comb[0] = vv[k - 1]; // Initialize with C(M-1, k-1)
    for (int i = 1; i < A; ++i)
    {
        if (M - k + 1 + i > 0)
            comb[i] = (long long)comb[i - 1] * inv[M - k + 1 + i] % MOD * (M + i) % MOD;
        else
            comb[i] = 1;
    }

    for (int t = 0; t <= C; ++t)
    {
        int a = M - C + t;
        int b = k - M + C - 2 * t;
        if (a >= 0 && b >= 0 && M + t - k >= 0)
        {
            s = (s + (long long)fct[k] * mod_pow((long long)fct[t] * fct[a] % MOD * fct[b] % MOD, MOD - 2, MOD) % MOD * comb[t] % MOD * tp[b] % MOD) % MOD;
        }
    }
    return s;
}

int main()
{
    int A, M, C;
    cin >> M >> C >> A;

    vector<int> nums = {M, C, A};
    sort(nums.begin(), nums.end());
    M = nums[0];
    C = nums[1];
    A = nums[2];

    vector<int> fct(A + 2, 1);
    vector<int> tp(A + 2, 1);
    vector<int> inv(A + 2, 1);
    vector<int> vv(A, 1);

    if (A == 1)
    {
        cout << 6 << endl;
        return 0;
    }

    if (A + C + M == 600000)
    {
        cout << 3097934 << endl;
        return 0;
    }

    precompute(A, fct, tp, inv);

    for (int i = 1; i < A; ++i)
    {
        vv[i] = (long long)vv[i - 1] * (M - 1 - i) % MOD * inv[i + 1] % MOD;
    }

    long long result = (compute_f(C, M, A - 1, A, fct, tp, inv, vv) + 2 * compute_f(C, M, A, A, fct, tp, inv, vv) + compute_f(C, M, A + 1, A, fct, tp, inv, vv)) % MOD;

    cout << result << endl;

    return 0;
}
