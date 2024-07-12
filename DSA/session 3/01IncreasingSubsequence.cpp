#pragma GCC optimize("-O2")

#include <bits/stdc++.h>

template <typename T>
using ordered_set = tree<T, null_type, std::less<T>, rb_tree_tag, tree_order_statistics_node_update>;

#define lli long long int
#define all(x) std::sort(((x).begin()), ((x).end()))
#define rev(x) std::reverse(((x).begin()), ((x).end()))
#define nall(x) x.begin(), x.end()
#define endl '\n';
#define Yes std::cout << "YES" << endl
#define No std::cout << "NO" << endl
#define stop(n) return void(std::cout << n << '\n');
#define ft first
#define sd second
#define pb push_back
#define pf push_front
#define em emplace
#define emb emplace_back
#define fi(i, n) for (int i = 0; i < n; i++)
#define fj(j, n) for (int j = 0; j < n; j++)
#define fstr(q, x) for (int(q) = 0; (q) < (x).size(); q++)
#define fref(x, y) for (auto &(x) : (y))
#define faut(x, y) for (auto(x) : (y))
#define out(v)                 \
    for (auto &e : v)          \
    {                          \
        std::cout << e << ' '; \
    }                          \
    std::cout << endl
#define in(v)          \
    for (auto &e : v)  \
    {                  \
        std::cin >> e; \
    }
#define invect(n, v)              \
    for (int i = 0; i < (n); i++) \
        std::cin >> v[i];
typedef long long ll;
typedef unsigned long long ull;
typedef bool flag;
typedef std::vector<int> vr;
typedef std::vector<ll> vrl;
typedef std::vector<std::vector<int>> vvr;
typedef std::vector<std::string> vss;
typedef std::vector<std::pair<int, int>> vpi;
typedef std::vector<std::pair<ll, ll>> vpill;
typedef std::vector<int>::iterator vit;
typedef std::pair<int, int> pr;
typedef std::map<int, int> mp;
typedef std::map<char, int> mch;
typedef std::map<std::string, int> mps;
typedef std::unordered_map<int, int> ump;
typedef std::priority_queue<int> piq;
typedef std::deque<int> dq;
typedef std::stack<int> sk;
typedef std::set<int> si;
typedef std::set<char> sc;
typedef std::unordered_set<int> ust;
const ll mod = 1e9 + 7, MOD = 998244353, MAXM = 9e5 + 5, INF = INT_MAX;
const int N = 3e5 + 5;
const long double PI = acos(-1);

void abuser()
{
    std::ios_base::sync_with_stdio(false);
    std::cin.tie(nullptr);
    std::cout.tie(nullptr);
#ifdef Clion
    freopen("input.txt", "r", stdin), freopen("output.txt", "w", stdout);
    freopen("ideal.in", "r", stdin), freopen("ideal.out", "w", stdout);
#endif
}
void Solution()
{
    // lazm tgeb akbr power of two as8r mn el rakm
    ll n;
    std::cin >> n;
    vrl v;
    ll p = n - 1, cnt = 1, j = 1;
    while (cnt <= p)
    {
        p -= cnt;
        cnt *= 2;
        v.pb(j);
        j++;
    }
    ll curr = 64;
    // while(p)
    while (curr--)
        if (p >> curr & 1)
            v.pb(curr + 1);
    if (v.size() > 200)
        stop(-1);
    std::cout << v.size() << endl out(v);
}

int main()
{
    abuser();
    int t = 1;
    std::cin >> t;
    while (t--)
    {
        Solution();
    }
}