# flutter_boilerplate

API THE MOVIE DATABASE
Login:
Step 1: Create new token:
GET: https://api.themoviedb.org/3/authentication/token/new?api_key=<<api_key>>

Step 2: Validate:
POST: https://api.themoviedb.org/3/authentication/token/validate_with_login?api_key=<<api_key>>
Request body: request token from step 1
{
"username": " ",
"password": " ",
"request_token": ""
}
Get popular movies:
GET: https://api.themoviedb.org/3/movie/popular?api_key=<<api_key>>&page=1
Get movies detail:
GET: https://api.themoviedb.org/3/movie/{movie_id}?api_key=<<api_key>>
Get movie credits:
GET: https://api.themoviedb.org/3/movie/{movie_id}/credits?api_key=<<api_key>>
Get movie keywords:
GET: https://api.themoviedb.org/3/movie/{movie_id}/keywords?api_key=<<api_key>>
Get movie recommendations:
GET: https://api.themoviedb.org/3/movie/{movie_id}/recommendations?api_key=<<api_key>>
Get movie trailers:
GET: https://api.themoviedb.org/3/movie/{movie_id}/videos?api_key=<<api_key>>
Get popular TV:
GET: https://api.themoviedb.org/3/tv/popular?api_key=<<api_key>> &page=1
Get TV detail:
GET: https://api.themoviedb.org/3/tv/{tv_id}?api_key=<<api_key>>
Get TV credits:
GET: https://api.themoviedb.org/3/tv/{tv_id}/credits?api_key=<<api_key>>
Get TV keywords:
GET: https://api.themoviedb.org/3/tv/{tv_id}/keywords?api_key=<<api_key>>

Get TV recommendations:
GET: https://api.themoviedb.org/3/tv/{tv_id}/recommendations?api_key=<<api_key>>
Get TV trailers:
GET: https://api.themoviedb.org/3/tv/{tv_id}/videos?api_key=<<api_key>>
Get trending:
GET: https://api.themoviedb.org/3/trending/{media_type}/{time_window}?api_key=<<api_key>>
Get person detail:
GET: https://api.themoviedb.org/3/person/{person_id}?api_key=<<api_key>>
Get search result:
GET: https://api.themoviedb.org/3/search/multi?api_key=<<api_key>>&page=1&query=<<query>>

API_KEY: 94f3c5b0c0011412ab4950d25a8cd4b9

Requirements:
- Using BloC để manage state
- Viết Reuse code
- Lưu trạng thái khi đăng nhập, lần sau vào app tự động đăng nhập
- Đầy đủ UI Requirements

Optionals:
- Đổi theme
- Đổi locale
- Sử dụng vân tay để authentication
