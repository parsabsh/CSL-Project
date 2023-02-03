#include <bits/stdc++.h>

using namespace std;

string lang[3];

bool bigger(string s, char a, char b, int lang_num)
{
    for(int i = 0;i < lang[lang_num].size();i++)
    {
        if(lang[lang_num][i] == b)
            return false;
        else if(lang[lang_num][i] == a)
            return true;
    }
}

bool exist(string s, int lang_num, char c)
{
    for(int i = 0;i < lang[lang_num].size();i++)
        if(c == lang[lang_num][i])
            return true;
    return false;
}

void solve(string s, int lang_num)
{
    string ans = "";
    string test = "";
    if(exist(s, lang_num, s[0]))
    {
        ans += s[0], test += s[0];
    }
    for(int i = 1;i < s.size();i++)
    {
        if((s[i - 1] == s[i] && exist(s, lang_num, s[i])) || (bigger(s, s[i - 1], s[i], lang_num) && exist(s, lang_num, s[i]) && exist(s, lang_num, s[i - 1])))
        {
            test += s[i];
            if(test.size() > ans.size())
                ans = test;
        }
        else
        {

            test = "";
            test += s[i];
        }
    }

    cout << ans << endl;
}

int main()
{
    string s;
    cin >> lang[0] >> lang[1] >> lang[2];
    cin >> s;
    solve(s, 0);
    solve(s, 1);
    solve(s, 2);
}
