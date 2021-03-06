# coding: utf-8
假如 /^系统已有网店布局$/ do
  Factory :page_mbaobao
end

假如 /^页面会显示操作表单$/ do
  # 鼠标悬停一秒后才显示提示面板
  sleep 2
  page.find('#tooltip').visible?.should eql true
end

而且 /^(.+)显示在(.+)之(前|后)$/ do |field, neighbor, direct|
  direct = ('前' == direct) ? :prev : :next
  #label = page.evaluate_script("$(\"#navs li a:contains('#{neighbor}')\").parent('li').#{direct}().text()")
  label = page.evaluate_script("$(\"li a:contains('#{neighbor}')\").parent('li').#{direct}().children('a').text()")
  label.chomp.should == field
end

#暂不支持后位置
而且 /^我?将(.+)移至(.+)(前|后){1}面$/ do |field, neighbor, direct|
  #修正链接display属性为block会导致拖动无效
  page.execute_script("$(\".sortable li a:contains('#{field}')\").css('display', 'inline')")
  page.execute_script("$(\".sortable li a:contains('#{neighbor}')\").css('display', 'inline')")

  #find(:xpath, "//li//a[contains(., '#{field}')]/..").drag_to(find(:xpath, "//li//a[contains(., '#{neighbor}')]/.."))
  find(".sortable li a:contains('#{field}')").drag_to(find(".sortable li a:contains('#{neighbor}')"))

  page.execute_script("$(\".sortable li a:contains('#{field}')\").css('display', 'block')")
  page.execute_script("$(\".sortable li a:contains('#{neighbor}')\").css('display', 'block')")
end
