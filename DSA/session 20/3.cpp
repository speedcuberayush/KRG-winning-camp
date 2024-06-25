#include <iostream>
#include <set>
using namespace std;

const int MAX = 300003;

int main()
{
    int q, n;
    long long c = 0;
    set<int> L;

    cin >> q >> n;
    L.insert(n);
    cout << c << endl;

    while (--q)
    {
        cin >> n;
        auto it = L.lower_bound(n);

        if (it == L.end())
        {
            it--;
            L.insert(n);
            if (it != L.begin())
            {
                it--;
                c += *it;
                it++;
            }
        }
        else if (it == L.begin())
            L.insert(n);
        else
        {
            auto it2 = it;
            it2--;
            c += *it2;
            L.insert(n);
        }

        cout << c << endl;
    }

    return 0;
}
