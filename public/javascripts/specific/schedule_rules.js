function checkBoxToggle(self, target_id)
{
  box = document.getElementById(self);
  toggle_visibility(target_id, box.checked);

};

function toggle_visibility(id, isVisible)
{
  var element = document.getElementById(id);
  if (isVisible==true)
    element.style.display = 'block';
  else
    element.style.display = 'none';  
}
