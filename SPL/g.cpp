#include <bits/stdc++.h>
using namespace std;

const long long BASE = 31;
const long long MOD = 1e9 + 7;

vector<long long> compute_hashes(const string &S) {
    int n = S.size();
    vector<long long> hashes(n + 1, 0);
    vector<long long> powers(n + 1, 1);
    for (int i = 1; i <= n; ++i) {
        powers[i] = (powers[i - 1] * BASE) % MOD;
    }
    for (int i = 0; i < n; ++i) {
        hashes[i + 1] = (hashes[i] * BASE + (S[i] - 'a' + 1)) % MOD;
    }
    
    return hashes;
}

long long get_hash(int l, int r, const vector<long long> &hashes, const vector<long long> &powers) {
    return (hashes[r + 1] - (hashes[l] * powers[r - l + 1]) % MOD + MOD) % MOD;
}

int main() {

    string S;
    cin >> S;
    
    int Q;
    cin >> Q;
    
    vector<long long> hashes = compute_hashes(S);
    vector<long long> powers(hashes.size());

    powers[0] = 1;
    for (int i = 1; i < powers.size(); ++i) {
        powers[i] = (powers[i - 1] * BASE) % MOD;
    }
    
    unordered_map<long long, int> hash_count;
    int len = S.size();
    for (int start = 0; start < len; ++start) {
        for (int end = start; end < len; ++end) {
            long long hash_value = get_hash(start, end, hashes, powers);
            hash_count[hash_value]++;
        }
    }

    while (Q--) {
        string Ti;
        cin >> Ti;
        int m = Ti.size();
        
        vector<long long> ti_hashes = compute_hashes(Ti);
        long long ti_hash = get_hash(0, m - 1, ti_hashes, powers);

        cout << hash_count[ti_hash] << "\n";
    }

    return 0;
}
