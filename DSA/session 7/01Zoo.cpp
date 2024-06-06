#include <iostream>
#include <vector>

using namespace std;

vector<int> computeKMPPrefix(const vector<int> &pattern)
{
    int m = pattern.size();
    vector<int> prefix(m, 0);
    int k = 0;
    for (int i = 1; i < m; ++i)
    {
        while (k > 0 && pattern[i] != pattern[k])
        {
            k = prefix[k - 1];
        }
        if (pattern[i] == pattern[k])
        {
            ++k;
        }
        prefix[i] = k;
    }
    return prefix;
}

int KMPSearch(const vector<int> &text, const vector<int> &pattern)
{
    int n = text.size();
    int m = pattern.size();
    if (m == 0)
        return n + 1;

    vector<int> prefix = computeKMPPrefix(pattern);
    int q = 0;
    int count = 0;
    for (int i = 0; i < n; ++i)
    {
        while (q > 0 && pattern[q] != text[i])

            q = prefix[q - 1];

        if (pattern[q] == text[i])
        {
            ++q;
        }
        if (q == m)
        {
            ++count;
            q = prefix[q - 1];
        }
    }
    return count;
}

int main()
{
    int n, w;
    cin >> n >> w;

    vector<int> a(n);
    for (int i = 0; i < n; ++i)
        cin >> a[i];

    vector<int> b(w);
    for (int i = 0; i < w; ++i)
        cin >> b[i];
    if (b.size() == 1)
    {
        cout << a.size() << endl;
        return 0;
    }

    if (w == 1)
    {

        int count = 0;
        for (int i = 0; i < n; ++i)
        {
            if (a[i] == b[0])
            {
                ++count;
            }
        }
        cout << count << endl;
        return 0;
    }

    vector<int> diffA(n - 1);
    vector<int> diffB(w - 1);
    for (int i = 1; i < n; ++i)
        diffA[i - 1] = a[i] - a[i - 1];
    for (int i = 1; i < w; ++i)
        diffB[i - 1] = b[i] - b[i - 1];

    int result = KMPSearch(diffA, diffB);
    cout << result << endl;

    return 0;
}
