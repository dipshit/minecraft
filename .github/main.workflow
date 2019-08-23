workflow "CI" {
  on = "push"
}

action "Validate yaml" {
  uses = "dipshit/kubeval@master"
  args = "k8s/*"
}
