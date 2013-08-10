include SugarCube::Adjust

class AppDelegate
  def application(application, didFinishLaunchingWithOptions:launchOptions)
    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)

    # Adding Motion-Xray's UIWindow shim
    #@window = Motion::Xray::XrayWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)

    @myRootController = RootController.controller

    @tabController = UITabBarController.alloc.initWithNibName(nil, bundle: nil)
    @tabController.viewControllers = [@myRootController]
    @tabController.wantsFullScreenLayout = true
    @window.rootViewController = @tabController
    @window.makeKeyAndVisible

    # If we aint logged in
    if App::Persistence['authToken'].nil?
      App.run_after(0.1) do
        showLoginController
      end
    end

    # include the SaveUIPlugin, which is not included by default
    #Motion::Xray.register(Motion::Xray::SaveUIPlugin.new)

    true
  end

  def showLoginController
    @loginController = LoginController.alloc.initWithNibName(nil, bundle: nil)
    @myRootController.presentModalViewController(@loginController, animated: true)

    puts "NOT LOGGED IN"
  end

end
