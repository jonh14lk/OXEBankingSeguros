(pwd() != @__DIR__) && cd(@__DIR__) # allow starting app from bin/ dir

using OXEBankingSeguros
const UserApp = OXEBankingSeguros
OXEBankingSeguros.main()
