Configuration EnableICMP
{
  Import-DscResource -ModuleName PSDesiredStateConfiguration, xNetworking

  Node localhost
  {
    #Enable ICMP in and out through Firewall
    xFirewall EnableV4PingIn
    {
        Name = "FPS-ICMP4-ERQ-In"
        Enabled = "True"
    }

    xFirewall EnableV4PingOut
    {
        Name = "FPS-ICMP4-ERQ-Out"
        Enabled = "True"
    }
  }
}