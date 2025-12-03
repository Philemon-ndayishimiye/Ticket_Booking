class ApiEndpoints {
static const baseUrl = 'https://my-ticketing-production.up.railway.app/api';
static const login = '/auth/login/'; 
static const logout ='/auth/logout/';
static const register ='/auth/register/';
static const requestOtp ='/auth/request_password_otp/';
static const resetpassword ='/auth/reset_password_with_otp/';
static const singleuser ='/auth/user';
static const completeProfile = '/auth/user/complete_profile/';
static const updateaccount ='/auth/user/update_account/';
static const contactUs ='/auth/user/contact_us/';
static const reportProblem ='/auth/user/report_problem/';

// events
static const events = '/events/';
static const eventsDetail='/events/';
}