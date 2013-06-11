//findElement().handleEvent('click', function() {
//});

getElementbyId("recurring_box").handleEvent('click', function() {
  box = document.getElementById("recurring_box");
  toggle_visibility("recurring_fields", box.checked);
  alert("test");

})

function checkBoxToggle(self, target)
{
  box = document.getElementById(self);
  toggle_visibility(target, box.checked);
  alert("test");
};

function toggle_visibility(id, isChecked)
{
  var element = document.getElementById(id);
  if (isChecked==true)
    element.style.display = 'block';
  else
    element.style.display = 'none';  
}
