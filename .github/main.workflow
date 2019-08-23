workflow "CI" {
  on = "push"
}

action "dipshit/kubeval" {
  uses = "dipshit/kubeval@master"
  args = "k8s/*"
}
