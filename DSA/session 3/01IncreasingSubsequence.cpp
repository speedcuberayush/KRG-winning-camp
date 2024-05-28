#include <iostream>
#include <vector>
using namespace std;

void findIncreasingSubsequences(int t, vector<long long> &cases)
{
    for (int i = 0; i < t; ++i)
    {
        long long X = cases[i];
        if (X == 2)
        {
            cout << 1 << endl;
            cout << 0 << endl;
            continue;
        }

        // Find the position of the most significant bit
        int msb_pos = 63 - __builtin_clzll(X - 1);
        vector<long long> array(msb_pos + 1, 1);

        long long remaining = X - (1LL << msb_pos);

        for (int j = 0; j < remaining; ++j)
        {
            array[j] = 0;
        }

        cout << array.size() << endl;
        for (int j = 0; j < array.size(); ++j)
        {
            cout << array[j] << " ";
        }
        cout << endl;
    }
}

int main()
{
    int t;
    cin >> t;

    vector<long long> cases(t);
    for (int i = 0; i < t; ++i)
    {
        cin >> cases[i];
    }

    findIncreasingSubsequences(t, cases);

    return 0;
}
