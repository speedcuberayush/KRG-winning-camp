#include <iostream>
#include <vector>
#include <algorithm>
using namespace std;

int maxMinPalindromeLength(int n, int k, const string &s)
{
    vector<int> freq(26, 0);
    for (char c : s)
        freq[c - 'a']++;

    int pairs = 0, singles = 0;
    for (int count : freq)
    {
        pairs += count / 2;
        singles += count % 2;
    }

    int left = 0, right = n / k;
    while (left <= right)
    {
        int mid = (left + right) / 2;
        if (pairs >= (mid / 2) * k)
            left = mid + 1;
        else
            right = mid - 1;
    }

    return right;
} 

int main()
{
    int t;
    cin >> t;
    while (t--)
    {
        int n, k;
        string s;
        cin >> n >> k >> s;
        cout << maxMinPalindromeLength(n, k, s) << endl;
    }
    return 0;
}
