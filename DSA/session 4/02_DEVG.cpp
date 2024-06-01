#include <bits/stdc++.h>
using namespace std;

bool nextPermutation(vector<int> &digits)
{
    int n = digits.size();
    int i = n - 2;

    while (i >= 0 && digits[i] >= digits[i + 1])
        i--;

    if (i == -1)
        return false;

    int j = n - 1;
    while (digits[j] <= digits[i])
        j--;

    swap(digits[i], digits[j]);
    reverse(digits.begin() + i + 1, digits.end());

    return true;
}

int main()
{
    int t;
    cin >> t;

    while (t--)
    {
        int n;
        cin >> n;
        vector<int> digits(n);

        for (int i = 0; i < n; i++)
            cin >> digits[i];

        if (nextPermutation(digits))
        {
            for (int digit : digits)
                cout << digit;

            cout << endl;
        }
        else
            cout << -1 << endl;
    }

    return 0;
}
