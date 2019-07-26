import UIKit
import Tabman
import Pageboy

class TabViewController: TabmanViewController {
    
    // Tabmanで表示するViewControllerの配列
    private var viewControllers: [UIViewController] = [UIViewController]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // PageboyのDataSourceをセット
        self.dataSource = self
        
        // Tabmanで表示するViewControllerを生成
        guard let firstVC = UIStoryboard(name: "FirstViewController", bundle: nil).instantiateInitialViewController(),
            let secondVC = UIStoryboard(name: "SecondViewController", bundle: nil).instantiateInitialViewController() else {
            return
        }
        
        // ViewControllersに表示するViewControllerをセット
        viewControllers = [firstVC, secondVC]
        
        // Barを作成
        let bar = TMBar.ButtonBar()
        bar.layout.transitionStyle = .snap
        
        // Barのボタンの表示の仕方
        // ボタンが多くなるなら .intrinsic の方が綺麗になります
        bar.layout.contentMode = .fit
        
        // Barの背景の設定
        bar.backgroundView.style = .blur(style: .light)
        
        // ボタンの下に表示されているインジケーターの色の設定
        bar.indicator.tintColor = .orange
        
        // Barに表示しているボタンの設定
        bar.buttons.customize { button in
            // 選択されていないボタンの色
            button.tintColor = .orange
            
            // 選択されているボタンの色
            button.selectedTintColor = .red
        }
        
        // 作成したBarを追加、追加しないと表示されないので注意
        addBar(bar, dataSource: self, at: .top)
        
        // コードなどで後からViewControllerを生成した場合はリロードさせる
        reloadData()
    }
}

extension TabViewController: PageboyViewControllerDataSource, TMBarDataSource {
    
    // 表示するViewControllerの数を設定
    func numberOfViewControllers(in pageboyViewController: PageboyViewController) -> Int {
        return viewControllers.count
    }
    
    // 各ページに対応するViewControllerを設定
    func viewController(for pageboyViewController: PageboyViewController, at index: PageboyViewController.PageIndex) -> UIViewController? {
        return viewControllers[index]
    }
    
    // 一番初めに表示するページを設定 nilの場合[0]
    func defaultPage(for pageboyViewController: PageboyViewController) -> PageboyViewController.Page? {
        return nil
    }
    
    // Barの部分に表示するタイトルを設定
    func barItem(for bar: TMBar, at index: Int) -> TMBarItemable {
        return TMBarItem(title: "Page \(index)")
    }
    
}
